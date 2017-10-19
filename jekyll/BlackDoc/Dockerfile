FROM jekyll/jekyll:3.5
LABEL mantainer "Jimmy Masías <jimmy.ilws@gmail.com>"

# bundle config SIN USAR "--use-system-libraries"
RUN git clone https://github.com/jimsrc/BlackDoc.git /srv/jekyll \
    && git checkout 1.0.1 && git clean -fd \
    && bundle config build.nokogiri \
    && bundle install \
    && rm -rf /srv/jekyll/*

#EOF
