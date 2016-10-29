from sqlalchemy_declarative import Child, SoundRecordings, Base
from sqlalchemy import create_engine

engine = create_engine('sqlite:///autistic.db')
Base.metadata.bind = engine

from sqlalchemy.orm import sessionmaker
DBSession = sessionmaker()
DBSession.bind = engine
session = DBSession()

def AddChild(name):
    newChild = Child(name=name)
    session.add(newChild)
    session.commit()

def GetChildId(name):
    print(session.query(Child).filter(Child.name == name).first().id)
    return session.query(Child).filter(Child.name == name).first()

def AddRecording(name, recording, meaning):
    srecrd = SoundRecordings(child_id=GetChildId(name), recording=recording, meaning=meaning)
    SoundRecordings.add(srecrd)

def GetRecordings(name):
    t = list()
    search_id = GetChildId(name)
    results = session.query(SoundRecordings).filter(search_id == SoundRecordings.id)
    
    for result in results:
        t.append((result.recording, result.meaning))
    return t
AddChild('Amy')
GetChildId('Amy')

