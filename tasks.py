from pathlib import Path
from invoke import task


@task
def build(ctx):
    ctx.run("docker-compose build", echo=True)

@task(pre=[build])
def up(ctx):
    ctx.run("docker-compose up", echo=True)

@task(pre=[build])
def update_deps(ctx):
    ret = ctx.run(
        "docker-compose run web pip-compile --strip-extras /requirements.in", 
        warn=True, echo=True, )
    requirements_text = (Path(".") / "docker" / "requirements.txt")
    print("Writing output to: ", requirements_text)
    requirements_text.write_text(ret.stderr)

@task
def pre(ctx):
    res = ctx.run("ls -la", echo=True, warn=True)
    print(res)