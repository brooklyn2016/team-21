from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from struct import pack
from sqlalchemy_declarative import Child, SoundRecordings, Base

engine = create_engine('sqlite:///autistic.db')

Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)

session = DBSession()

new_child = Child(name='Ann')
session.add(new_child)
session.commit()

new_child = Child(name='John')
session.add(new_child)
session.commit()

new_child = Child(name='Mary')
session.add(new_child)
session.commit()

new_child = Child(name='James')
session.add(new_child)
session.commit()

new_child = Child(name='Harry')
session.add(new_child)
session.commit()

session.commit()




