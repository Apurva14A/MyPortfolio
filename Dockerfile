# Use an official Python runtime as the base image
FROM python:3.10.6-alpine 

LABEL maintainer="Ashutosh Apurva"
LABEL image_type="Django app v1.2"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Create a non root user 

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
    

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

USER appuser

# Copy the project code to the working directory
 COPY . .

# Expose the port on which the Django application will run
EXPOSE 8000

# Run the Django development server
CMD ["gunicorn", "myPortfolio.wsgi:application", "--bind", "0.0.0.0:8000"]
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


# Multistage build for Django app

# FROM python:3.10.6-slim
# COPY --from=build /app /portfolio
# COPY --from=build requirements.txt /app
# RUN pip install -r requirements.txt && rm -rf /app/*.txt
# EXPOSE 8000
# CMD ["gunicorn", "myPortfolio.wsgi:application", "--bind", "0.0.0.0:8000"]
