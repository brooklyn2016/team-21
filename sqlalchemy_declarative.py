import os
import sys
from sqlalchemy import Column, ForeignKey, Integer, String, LargeBinary
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()

class Child(Base):
    __tablename__ = 'child'
    id = Column(Integer, primary_key=True)
    name = Column(String(250), nullable=False)

class SoundRecordings(Base):
    __tablename__ = 'soundrecordings'
    id = Column(Integer, primary_key=True)
    child_id = Column(Integer, ForeignKey('child.id'))
    recording = Column(LargeBinary, nullable=False)
    meaning = Column(String(256), nullable=False)

engine = create_engine('sqlite:///autistic.db')

Base.metadata.create_all(engine)
