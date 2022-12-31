package de.olf.requestcamaccess;

import java.io.IOException;

import cz.adamh.utils.NativeUtils;

public class Requestor {

	static {
    	try {
    		NativeUtils.loadLibraryFromJar("/" + System.mapLibraryName("SwiftCode"));
			NativeUtils.loadLibraryFromJar("/" + System.mapLibraryName("SwiftRequestAccess"));
		} catch (IOException e) {
			e.printStackTrace();
		} 
    }

    public static native void RequestAccessImpl();

    public static void main(final String[] args) {
        RequestAccessImpl();      
    }
}