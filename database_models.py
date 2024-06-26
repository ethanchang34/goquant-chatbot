from sqlalchemy import create_engine, Column, String, DateTime, Boolean, JSON, Integer
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import uuid
import datetime

Base = declarative_base()

class OKXAccount(Base):
    __tablename__ = 'account'
    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    created_at = Column(DateTime, default=datetime.datetime.now(datetime.timezone.utc))
    scheduled_timestamp = Column(DateTime)
    data = Column(JSON)
    validated = Column(Boolean, default=False)

class Order(Base):
    __tablename__ = 'orders'
    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    oems_algorithm_id = Column(Integer)
    order_id = Column(String)
    status = Column(String)
    data = Column(JSON)
    validated = Column(Boolean, default=False)
    created_at = Column(DateTime)
    updated_at = Column(DateTime, default=datetime.datetime.now(datetime.timezone.utc))

class Metrics(Base):
    __tablename__ = 'metrics'
    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    exchange = Column(String)
    created_at = Column(DateTime, default=datetime.datetime.now(datetime.timezone.utc))
    scheduled_timestamp = Column(DateTime)
    portfolio_account_metrics = Column(JSON)
    portfolio_return_metrics = Column(JSON)
    portfolio_risk_metrics = Column(JSON)
    portfolio_execution_quality_metrics = Column(JSON)
    position_execution_quality_metrics = Column(JSON)
    position_risk_metrics = Column(JSON)
    position_return_metrics = Column(JSON)
    timeframe = Column(String)

engine = create_engine('sqlite:///trading.db')
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)
session = Session()
