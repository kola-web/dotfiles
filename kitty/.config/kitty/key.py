import os

if 'TMUX' in os.environ:
    print('tmux')
else:
    print('Not in tmux!')
