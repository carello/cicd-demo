FROM registry1:5001/pythonbase:latest
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5010
ENTRYPOINT ["python"]
CMD ["app.py"]
