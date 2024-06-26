from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from database_models import OKXAccount, Order, Metrics
import spacy

nlp = spacy.load("en_core_web_sm")

portfolio_account_metrics = {
    'net asset value': 'net_asset_value',
    'assets': 'assets',
    'cash': 'cash',
    'margin': 'margin',
    'buying power': 'buying_power',
    'margin utilization': 'margin_utilization',
    'margin available': 'margin_available',
    'volume': 'volume',
    'turnover': 'turnover',
    'number of trades': 'number_of_trades'
}
portfolio_return_metrics = {
    'unrealized pnl': 'unrealized_pnl',
    'realized pnl': 'realized_pnl',
    'avg pnl per trade': 'avg_pnl_per_trade',
    'avg positive pnl': 'avg_positive_pnl',
    'avg negative pnl': 'avg_negative_pnl',
    'fees': 'fees',
    'cagr': 'cagr',
    'win rate': 'win_rate',
    'up time': 'up_time',
    'down time': 'down_time',
    'total trades': 'total_trades',
    'long trades': 'long_trades',
    'short trades': 'short_trades'
}
portfolio_risk_metrics = {
    'concentration': 'concentration',
    'value at risk': 'value_at_risk',
    'volatility': 'volatility',
    'standard deviation': 'standard_deviation',
    'beta': 'beta',
    'sharpe': 'sharpe',
    'max drawdown': 'max_drawdown',
    'drawdown period': 'drawdown_period',
    'drawdown recovery': 'drawdown_recovery',
    'max runup': 'max_runup',
    'runup period': 'runup_period',
}

class ActionGreet(Action):
    def name(self) -> str:
        return "action_greet"
    
    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        dispatcher.utter_message(text="Hello! How can I help you?")
        return []

class ActionGoodbye(Action):
    def name(self) -> str:
        return "action_goodbye"
    
    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        dispatcher.utter_message(text="Bye!")
        return []

class ActionShowPortfolioPerformance(Action):
    def name(self) -> str:
        return "action_show_portfolio_performance"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        engine = create_engine('sqlite:///trading.db')
        Session = sessionmaker(bind=engine)
        session = Session()

        # Fetch portfolio performance data
        metrics = session.query(Metrics).first()
        portfolio_performance = metrics.portfolio_return_metrics if metrics else {}

        response = f"Portfolio Performance: {portfolio_performance}"
        dispatcher.utter_message(text=response)

        return []

class ActionCurrentValueHoldings(Action):
    def name(self) -> str:
        return "action_current_value_holdings"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        engine = create_engine('sqlite:///trading.db')
        Session = sessionmaker(bind=engine)
        session = Session()

        # Fetch current value of holdings
        account = session.query(OKXAccount).first()
        total_eq = account.data['totalEq'] if account else "N/A"

        response = f"Current value of holdings: {total_eq}"
        dispatcher.utter_message(text=response)

        return []

class ActionSummarizeTradingActivities(Action):
    def name(self) -> str:
        return "action_summarize_trading_activities"
    
    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        engine = create_engine('sqlite:///trading.db')
        Session = sessionmaker(bind=engine)
        session = Session()

        # Fetch recent live trading activity
        recent_live_trades = session.query(Order).filter(Order.status == 'live').order_by(Order.created_at.desc()).limit(5).all()
        recent_live_trades_info = [f"Order ID: {trade.order_id}, Status: {trade.status}, Instrument: {trade.data['filled']['instId']}, Price: {trade.data['filled']['px']}, Size: {trade.data['filled']['sz']}" for trade in recent_live_trades]
        
        # Fetch recent filled trading activity
        recent_filled_trades = session.query(Order).filter(Order.status == 'filled').order_by(Order.created_at.desc()).limit(5).all()
        recent_filled_trades_info = [f"Order ID: {trade.order_id}, Status: {trade.status}, Instrument: {trade.data['filled']['instId']}, Price: {trade.data['filled']['px']}, Size: {trade.data['filled']['sz']}" for trade in recent_filled_trades]


        response = f"Recent Live Orders:\n" + "\n".join(recent_live_trades_info) + "\nRecent Filled Orders:\n" + "\n".join(recent_filled_trades_info)
        dispatcher.utter_message(text=response)

        return []
    
class ActionLastTradeFee(Action):
    def name(self) -> str:
        return "action_last_trade_fee"
    
    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        engine = create_engine('sqlite:///trading.db')
        Session = sessionmaker(bind=engine)
        session = Session()

        # Fetch last trade fee
        order = session.query(Order).order_by(Order.created_at.desc()).first()
        fee = order.data[order.status]['fee'] if order else "N/A"
        feeCcy = order.data[order.status]['feeCcy'] if order else "N/A"

        response = f"Last trade fee: {fee} {feeCcy}"
        dispatcher.utter_message(text=response)

        return []
    
class ActionCurrentPositions(Action):
    def name(self) -> str:
        return "action_current_positions"
    
    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        engine = create_engine('sqlite:///trading.db')
        Session = sessionmaker(bind=engine)
        session = Session()

        # Fetch current positions
        account = session.query(OKXAccount).first()
        positions = {}

        if account:
            for holding in account.data['details']:
                positions[holding['ccy']] = {
                    'Currency': holding['ccy'],
                    'Equity': holding['eq'],
                    'Equity in USD': holding['eqUsd'],
                }

        response = f"Current positions: {positions}"
        dispatcher.utter_message(text=response)

        return []
    
class ActionShowMetric(Action):
    def name(self) -> str:
        return "action_show_metric"
    
    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict):
        engine = create_engine('sqlite:///trading.db')
        Session = sessionmaker(bind=engine)
        session = Session()

        metric = next(tracker.get_latest_entity_values('metric'), None)
        if not metric:
            dispatcher.utter_message(text="No metric entity found.")
            return []

        value = -1
        # map metric input to db column
        if metric in portfolio_account_metrics:
            metric = portfolio_account_metrics[metric]

            # Fetch metric value
            metrics = session.query(Metrics).first()
            value = metrics.portfolio_account_metrics[metric] if metrics else "N/A"
        elif metric in portfolio_return_metrics:
            metric = portfolio_return_metrics[metric]

            # Fetch metric value
            metrics = session.query(Metrics).first()
            value = metrics.portfolio_return_metrics[metric] if metrics else "N/A"
        elif metric in portfolio_risk_metrics:
            metric = portfolio_risk_metrics[metric]

            # Fetch metric value
            metrics = session.query(Metrics).first()
            value = metrics.portfolio_risk_metrics[metric] if metrics else "N/A"
        else:
            dispatcher.utter_message(text=f"I did not recognize {metric}. Is it spelled correctly?")
        response = f"{metric}: {value}"
        dispatcher.utter_message(text=response)
        return []
    