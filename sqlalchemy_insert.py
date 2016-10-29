from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from sqlalchemy_declarative import Child, SoundRecordings

engine = create_engine('sqlite:///autistic.db')

Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)

session = DBSession()

new_child = Child(name='Ann')
session.add(new_person)
session.commit()

new_child = Child(name='John')
session.add(new_person)
session.commit()

new_child = Child(name='Mary')
session.add(new_person)
session.commit()

new_child = Child(name='James')
session.add(new_person)
session.commit()

new_child = Child(name='Harry')
session.add(new_person)
session.commit()

new_sndRcrd = SoundRecordings(child_id=1, recording=pack('A', 365))
session.add(new_sndRcrd)

new_sndRcrd = SoundRecordings(child_id=2, recording=pack('B', 365))
session.add(new_sndRcrd)

new_sndRcrd = SoundRecordings(child_id=1, recording=pack('C', 365))
session.add(new_sndRcrd)

new_sndRcrd = SoundRecordings(child_id=3, recording=pack('D', 365))
session.add(new_sndRcrd)

new_sndRcrd = SoundRecordings(child_id=2, recording=pack('E', 365))
session.add(new_sndRcrd)

session.commit()




