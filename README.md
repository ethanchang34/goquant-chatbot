# Crypto Portfolio Chatbot for GoQuant Online Assessment

## Overview

The Crypto Portfolio Chatbot allows clients to interact with their portfolio metrics and trading activity data through a natural language interface. It leverages Natural Language Processing (NLP) to interpret user queries and provides insights based on data stored in an SQLite database ./trading.db

## Features

- Answer user queries regarding portfolio performance, holdings, recent trading activities, and trading fees.
- Compute and provide insights based on the data in the database.
- Predefined commands the chatbot can handle:
  - "Show my portfolio performance for the last month."
  - "What is the current value of my holdings?"
  - "Summarize my recent trading activities."
  - "What’s my last trade fee?"
  - "What are my current positions?"

## Environment Setup
Create a virtual environment
```
python -m venv .venv
```

Activate the virtual environment
Windows:
```
.\.venv\Scripts\activate
```
MacOS/Linux:
```
source .venv/bin/activate
```

Install required packages:
```
pip install rasa spacy sqlalchemy
python -m spacy download en_core_web_md
```