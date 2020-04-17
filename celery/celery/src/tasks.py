from celery import Celery
from tools.config import BROKER_URL, LOGGING

from random import random

import logging
import logging.config

log = logging.getLogger('celery')
logging.config.dictConfig(LOGGING)

SCHEDULE = {
    'add-every-5-seconds' : {
        'task': 'tasks.add',
        'schedule': 5.0,
        'args': (random(), random())
    },
}

celery = Celery('tasks', broker=BROKER_URL)
celery.conf.beat_schedule = SCHEDULE

@celery.task
def add(x, y):
    z = x + y
    log.info('The result of {} + {} is {}'.format(
        x,
        y,
        z
    ))

    return z
