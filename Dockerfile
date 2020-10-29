FROM python:3.7-slim
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
ENV NAME World
EXPOSE 80
CMD ["python", "run.py"]