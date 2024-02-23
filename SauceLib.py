import random


def get_random_item(values: dict[str, str]) -> tuple[str, str]:
    item = random.choice(list(values.items()))
    return item
