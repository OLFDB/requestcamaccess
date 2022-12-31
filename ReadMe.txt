In src directory:

swiftc Requestor.swift -emit-library -o libSwiftCode.dylib -Xlinker -install_name -Xlinker libSwiftCode.dylib
javac -cp "../native-utils-1.0-SNAPSHOT.jar" -h . de/olf/requestcamaccess/Requestor.java 
gcc -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/darwin/" -o libSwiftRequestAccess.dylib -dynamiclib de_olf_requestcamaccess_requestor.c libSwiftCode.dylib
