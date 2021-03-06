FROM python:3.7-slim
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
ENV NAME Buttercup
EXPOSE 5000
CMD ["python", "run.py"]