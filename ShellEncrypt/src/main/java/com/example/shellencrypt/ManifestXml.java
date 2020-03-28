package com.example.shellencrypt;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.Namespace;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.XMLOutputter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

class ManifestXml {
    private static String appKey = "APPLICATION_CLASS_NAME";
//    private static String proxyApp = "f8left.shell2.ProxyApplication";
    private static String proxyApp = "com.example.protectappnative.ProxyApplication";

    private static final String NAME_SPACE = "http://schemas.android.com/apk/res/android";
    private static final String NAME_PREFIX = "android";
    private static final String META_DATA = "meta-data";
    private static final String NAME = "name";
    private static final String VALUE = "value";

    //处理AndroidManifest.xml文件
    public static void modify(File xmlFile) {
        SAXBuilder builder = new SAXBuilder();
        String oldApplication = null;
        try {
            Document doc = builder.build(xmlFile);
            Element root = doc.getRootElement();
            Element application = root.getChild("application");

            Namespace ns = Namespace.getNamespace(NAME_PREFIX, NAME_SPACE);
            Attribute attribute = application.getAttribute(NAME, ns);
            if(attribute != null) {
                oldApplication = attribute.getValue();
                attribute.setValue(proxyApp);
            } else {
                application.setAttribute(NAME, proxyApp, ns);
            }

            if (oldApplication != null) {
                application.addContent(new Element(META_DATA).setAttribute(NAME, appKey, ns).setAttribute(VALUE, oldApplication, ns));
            }
            XMLOutputter xmlOutputter = new XMLOutputter();
            xmlOutputter.output(doc, new FileOutputStream(xmlFile));
        } catch (JDOMException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
