FROM python:2.7

RUN mkdir -p /usr/src/test
COPY testScript.py /usr/src/app/

RUN pip install ipython cassandra-driver

CMD ["ipython", "/usr/src/app/testScript.py"] 
