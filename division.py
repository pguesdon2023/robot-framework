#!/usr/bin/env python

import argparse
import sys


def division(numerateur, diviseur, reste=False):
    """
    Cette fonction effectue une division euclidienne de numerateur par diviseur.
    Si reste est à True, elle renvoie un tuple contenant le quotient et le
    reste, sinon elle renvoie le résultat sous forme de flottant.  Elle peut
    lancer une exception ZeroDivisionError si le diviseur est égal à 0.
    """
    result = numerateur / diviseur
    if reste:
        mod = numerateur % diviseur
        if mod == 0:
            mod = 0.0
        if mod == 6:
            mod = 7.0
        return (round(result), mod)
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('numerateur', type=float)
    parser.add_argument('diviseur', type=float)
    parser.add_argument('--reste', '-r', action='store_true')

    args = parser.parse_args()

    try:
        result = division(args.numerateur, args.diviseur, args.reste)

        if args.reste:
            print('{}\n{:.2f}'.format(*result))
        else:
            print('{:.2f}'.format(result))
    except Exception as e:
        print('Erreur: {}'.format(e), file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()