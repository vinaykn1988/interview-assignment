"""Display helpers for Jupyter notebooks."""

import pandas as pd
from IPython.display import HTML


def html_table(rows, head=None, tail=None):
    """Render a list of dicts as an HTML table in Jupyter.

    Args:
        rows: iterable of dicts (e.g. csv.DictReader output)
        head: show the first N rows
        tail: show the last N rows
        (pass both for head + tail sampling; pass neither to show all)
    """
    if not rows:
        return HTML('<p>(empty)</p>')
    df = pd.DataFrame(rows)
    if head is not None and tail is not None:
        if len(df) > head + tail:
            df = pd.concat([df.head(head), df.tail(tail)])
    elif head is not None:
        df = df.head(head)
    elif tail is not None:
        df = df.tail(tail)
    return HTML(df.to_html(index=False))
