import os

BROKER_URL = os.environ.get('CELERY_BROKER_URL', 'amqp://')

LOGGING = {
    'version': 1,
    'root': {
        'level': os.environ.get('LOGLEVEL', 'INFO').upper(),
        'handlers': ['console'],
    },
    'formatters': {
        'default': {
            'format': '%(asctime)s %(levelname)s [%(module)s:%(funcName)s:%(lineno)d] ' \
            '%(message)s',
            'datefmt': '%Y-%m-%d %H:%M:%S',
        },
    },
    'handlers': {
        'console': {
            'level': os.environ.get('LOGLEVEL', 'INFO').upper(),
            'formatter': 'default',
            'class': 'logging.StreamHandler',
        }
    },
    'loggers': {
        'celery': {
            'level': os.environ.get('LOGLEVEL', 'INFO').upper(),
            'propagate': True
        },
    },
}
