#!/bin/bash

./gradlew assemble

#java -cp build/libs/bookrecommendation-0.1.jar io.micronaut.graal.reflect.GraalClassLoadingAnalyzer

native-image --no-server \
             --class-path build/libs/bookrecommendation-0.1.jar \
             -H:ReflectionConfigurationFiles=reflect.json \
             -H:EnableURLProtocols=http \
             -H:IncludeResources="logback.xml|application.yml" \
             -H:Name=bookrecommendation \
             -H:Class=example.micronaut.bookrecommendation.Application \
             -H:+ReportUnsupportedElementsAtRuntime \
             -H:+AllowVMInspection \
             --allow-incomplete-classpath \
             --rerun-class-initialization-at-runtime='sun.security.jca.JCAUtil$CachedSecureRandomHolder,javax.net.ssl.SSLContext' \
             --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder,io.netty.handler.ssl.util.ThreadLocalInsecureRandom,com.sun.jndi.dns.DnsClient