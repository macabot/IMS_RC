function save_movie(frames, movie_name, fps, quality, compression)

curr_movie = avifile(movie_name, 'fps', fps, 'quality', quality, ...
    'Compression', compression);
curr_movie = addframe(curr_movie, frames);
curr_movie = close(curr_movie);
