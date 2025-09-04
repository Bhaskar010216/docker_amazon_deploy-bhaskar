# Use official Tomcat image
FROM tomcat:9.0
# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy WAR file into Tomcat
COPY Amazon.war /usr/local/tomcat/webapps/Amazon.war
# Expose default Tomcat port
EXPOSE 8080
# Start Tomcat
CMD ["catalina.sh", "run"]
