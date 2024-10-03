FROM python:3.12.6
ENV PYTHONUNBUFFERED=1 
ENV PYTHONDONTWRITEBYTECODE=1
RUN apt-get update && apt-get install -y sudo postgresql-client && apt-get clean
RUN pip install pip-tools

RUN useradd --uid 1000 -ms /bin/bash -d /home/notebook/ -G sudo notebook
RUN echo "%sudo  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY examples/ /home/examples
COPY entrypoint.sh /entrypoint.sh
COPY requirements.in /requirements.in
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

WORKDIR /home/notebook


CMD ["/bin/bash", "/entrypoint.sh"]