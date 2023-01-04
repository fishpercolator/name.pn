FROM ruby:3.1.3

ARG UID=1001
COPY vendor/prepare-env.sh /tmp
RUN /tmp/prepare-env.sh $UID

# Assume the app will be mounted here by docker-compose
ENV APP /usr/src/app
RUN mkdir $APP
WORKDIR $APP

ENV GEM_HOME $APP/vendor/bundle
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

ENV DEFAULT_DOMAIN localhost

ENTRYPOINT ["vendor/docker-entrypoint.sh"]
LABEL "com.datadoghq.ad.logs"='[{"source": "ruby", "service": "name-pn"}]'
CMD ["foreman", "start", "-f", "Procfile.dev"]
