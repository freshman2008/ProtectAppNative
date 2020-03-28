package com.example.protectappnative;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class RefInvoke {
    public static Object invokeStaticMethod(String classname, String methodname, Class[] paramTypes, Object[] paramValues) {
        try {
            Class<?> objClass = Class.forName(classname);
            Method method = objClass.getDeclaredMethod(methodname, paramTypes);
            return method.invoke(null, paramValues);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Object invokeMethod(String classname, String methodname, Object obj, Class[] paramTypes, Object[] paramValues) {
        try {
            Class<?> objClass = Class.forName(classname);
            Method method = objClass.getDeclaredMethod(methodname, paramTypes);
            return method.invoke(obj, paramValues);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void setFieldObject(String classname, String fieldname, Object obj, Object fieldValue) {
        try {
            Class objClass = Class.forName(classname);
            Field field = objClass.getDeclaredField(fieldname);
            field.setAccessible(true);
            field.set(obj, fieldValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Object getFieldObject(String classname, Object obj, String fieldname) {
        try {
            Class objClass = Class.forName(classname);
            Field field = objClass.getDeclaredField(fieldname);
            field.setAccessible(true);
            return field.get(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void setStaticObject(String classname, String fieldname, Object fieldValue) {
        try {
            Class objClass = Class.forName(classname);
            Field field = objClass.getDeclaredField(fieldname);
            field.setAccessible(true);
            field.set(null, fieldValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Object getStaticObject(String classname, String fieldname) {
        try {
            Class objClass = Class.forName(classname);
            Field field = objClass.getDeclaredField(fieldname);
            field.setAccessible(true);
            return field.get(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
