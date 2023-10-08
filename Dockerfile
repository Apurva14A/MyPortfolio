# Use an official Python runtime as the base image
FROM python:3.10.6-alpine AS build

LABEL maintainer="Ashutosh Apurva"
LABEL image_type="Django app v1.2"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the project code to the working directory
 COPY . /app

# Copy the requirements file
COPY requirements.txt .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt 

# Expose the port on which the Django application will run
#EXPOSE 8000

# Run the Django development server
CMD ["gunicorn", "myPortfolio.wsgi:application", "--bind", "0.0.0.0:8000"]
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


# Multistage build for Django app

FROM python:3.10.6-slim
COPY --from=build /app /portfolio
COPY --from=build requirements.txt /app
RUN pip install -r requirements.txt && rm -rf /app/*.txt
EXPOSE 8000
CMD ["gunicorn", "myPortfolio.wsgi:application", "--bind", "0.0.0.0:8000"]
