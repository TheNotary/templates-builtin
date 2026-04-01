package com.example.java.myappgroup;

// This library was installed as a dependency via the pom.xml file
import org.apache.commons.lang3.StringUtils;

/**
 * Hello world!
 *
 */
public class App
{
    public static void main( String[] args )
    {
        String myString = "";

        if ( StringUtils.isEmpty(myString) ) {
            System.out.println( "It was empty" );
        }
        else {
           System.out.println( "It was FULL" );
        }

        String myProp = System.getProperty("launchtime_property");

        Utils utils = new Utils();

        System.out.println( "Hello World!  Here's a property:  " + myProp + " " + utils.performWork() );
    }
}
