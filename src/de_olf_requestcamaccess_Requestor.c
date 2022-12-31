#include <jni.h>
#include <stdio.h>
#include "de_olf_requestcamaccess_Requestor.h"
#include "de_olf_requestcamaccess_Requestor_swift.h"

JNIEXPORT void JNICALL Java_de_olf_requestcamaccess_Requestor_RequestAccessImpl
  (JNIEnv *env, jclass clazz) {

    int result = swiftRequestAccess(0);
    printf("%s%i%s", "Access Request Result: ", result, " (11->already authorized), (22->denied), (33->prompted authorized), (34->prompted denied), (35->Should not occur)\n");

}
