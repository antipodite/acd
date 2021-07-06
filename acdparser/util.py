import re
import functools

from bs4 import Tag

__all__ = ['normalize_years', 'parse_form', 'next_tag', 'previous_tag', 'set_from_href']


def set_from_href(a):
    f, _, pid = a['href'].partition('#')
    return f.replace('acd-', '').replace('.htm', '').split('_')[0], pid


def normalize_years(ref):
    ref = re.sub(r'\-([0-9]{4})', lambda m: '/' + m.groups()[0][2:], ref)
    return re.sub(r'\-([0-9]{2})', lambda m: '/' + m.groups()[0], ref)


def parse_form(s, is_proto):
    s = re.sub(r'\s+', ' ', s.strip())
    if is_proto and s.startswith('*'):
        return s[1:].strip()
    return s


def _tag(attr, e):
    n = getattr(e, attr)
    if n is None:
        return
    while not isinstance(n, Tag):
        n = getattr(n, attr)
        if n is None:
            return
    return n


previous_tag = functools.partial(_tag, 'previous_sibling')
next_tag = functools.partial(_tag, 'next_sibling')