FROM drewwestphal/wordpress

ENV TGMPA_PLUGIN_VERSION 0.1.3

# install this the manual way, the other way keeps crashing
ENV TGMPA_COMMAND_FILEPATH $WP_CLI_CONF_DIR/command.php
ADD "https://raw.githubusercontent.com/itspriddle/wp-cli-tgmpa-plugin/v$TGMPA_PLUGIN_VERSION/command.php" "$TGMPA_COMMAND_FILEPATH"
RUN chown $WP_CLI_USER $TGMPA_COMMAND_FILEPATH



RUN mkdir -p /usr/local/src/CC2/wp-plugin && \
    mkdir -p /usr/local/src/CC2-client/plugin;



COPY cc2-entrypoint.sh /usr/local/bin
ENTRYPOINT ["cc2-entrypoint.sh"]
CMD ["php-fpm"]
