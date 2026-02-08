# A list of substitutions to make within the dictated text
substitutions = [('period', '.'),
                ('comma', ','),
                ('new line', '\r'),
                ('dash', '-'),
                ('back slash', '\\'),
                ('forward slash', '/'),
                ('question mark', '?'),
                ('exclamation mark', '!'),
                ('ampersand', '&'),
                ('asterisk', '*')
]

def nerd_dictation_process(text):
    # Substitute in alternate text for any entries within substitutions list
    for substitution in substitutions:
        text = text.replace(' ' + substitution[0], substitution[1])
        text = text.replace(substitution[0], substitution[1])

    # Fix any new lines with a trailing space
    text = text.replace('\r ', '\r')

    return text
