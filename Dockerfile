# Use an official Python runtime as the base image
FROM python:3.10.6

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project code to the working directory
COPY . /app/

# Expose the port on which the Django application will run
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
