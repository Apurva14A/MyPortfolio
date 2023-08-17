# Use an official Python runtime as the base image
FROM python:3.10.6-slim

LABEL maintainer="Ashutosh Apurva"
LABEL image_type="Django app v1.2"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copy the project code to the working directory
COPY . /app/

# Set the working directory in the container
WORKDIR /app

# Creating Virtual environment
RUN python3 -m venv my_env

# Copy the requirements file
COPY requirements.txt .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt



# Expose the port on which the Django application will run
EXPOSE 8000

# Run the Django development server
CMD ["gunicorn", "myPortfolio.wsgi:application", "--bind", "0.0.0.0:8000"]
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
