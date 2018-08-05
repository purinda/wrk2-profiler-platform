FROM python:3-alpine3.7
COPY . /usr/src/app

WORKDIR /usr/src/app
RUN pip install -qIU --no-warn-conflicts -r requirements.txt

CMD ["python", "/usr/src/app/app.py"]