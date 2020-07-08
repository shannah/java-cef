// Copyright (c) 2014 The Chromium Embedded Framework Authors. All rights
// reserved. Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

package org.cef.browser;

import org.cef.CefClient;

/**
 * Creates a new instance of CefBrowser according the passed values
 */
public class CefBrowserFactory {
    private static CefBrowserFactory instance;
    
    public static CefBrowserFactory setInstance(CefBrowserFactory i) {
        CefBrowserFactory old = instance;
        instance = i;
        return old;
    }
    
    public static CefBrowserFactory getInstance() {
        if (instance == null) {
            instance = new CefBrowserFactory();
        }
        return instance;
    }
    
    public CefBrowser create(CefClient client, String url, boolean isOffscreenRendered,
            boolean isTransparent, CefRequestContext context) {
        if (isOffscreenRendered) return new CefBrowserOsr(client, url, isTransparent, context);
        return new CefBrowserWr(client, url, context);
    }
}
