FROM python:3.7-slim
RUN mkdir /app
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
ENV NAME World
EXPOSE 5000
CMD ["python", "run.py"]