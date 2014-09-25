/**
 * Copyright (C) 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package controllers;

import ch.reboundsoft.shinobi.authstore.AuthStore;
import ch.reboundsoft.shinobi.annotations.Authenticated;
import ch.reboundsoft.shinobi.annotations.ReqiresPermissions;
import com.google.inject.Inject;
import com.google.inject.Singleton;
import ch.reboundsoft.shinobi.filter.Shinobi;
import ch.reboundsoft.shinobi.filter.ValidateCookie;
import ninja.Context;
import ninja.FilterWith;
import ninja.Result;
import ninja.Results;
import ninja.cache.NinjaCache;
import ninja.params.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Singleton
@FilterWith({ValidateCookie.class, Shinobi.class})
public class ApplicationController {

    private static final transient Logger log = LoggerFactory.getLogger(ApplicationController.class);

    public final String USERNAME = "shiro-username";

    @Inject
    AuthStore subjects;

    @Inject
    NinjaCache ninjaCache;

    public Result indexGET() {

        return Results.html();

    }

    @Authenticated
    public Result profileGET(Context ctx) {

        String name = ctx.getSession().get(USERNAME);

        Result res = Results.html();
        res.render("username", name);

        return res;
    }

    @Authenticated
    @ReqiresPermissions("lightsaber:wield")
    public Result securedGET(Context ctx) {
        String name = ctx.getSession().get(USERNAME);
        Result res = Results.html();
        res.render("username", name);

        return res;
    }

    public Result loginGET() {
        //log.info(ninjaCache.get("test").toString());
        return Results.html();
    }

    public Result loginPOST(Context ctx, @Param("username") String name, @Param("password") String password) {

        log.info(name);
        log.info(password);

        if (name != null) {

            if (subjects.login(name, password)) {
                log.info("Username " + name + " authenticated");
                ctx.getSession().put(USERNAME, name);
                return Results.redirect("/profile");
            } else {
                log.info("Username " + name + " NOT authenticated");
                return Results.redirect("/login");
            }

        } else {
            log.info("Username empty");
            return Results.redirect("/login");
        }

    }

    public Result logoutGET(Context ctx) {

        log.info("Username " + ctx.getSession().get(USERNAME) + " logging out");
        subjects.logout(ctx.getSession().get(USERNAME));
        ctx.getSession().clear();
        return Results.redirect("/loggedout");
    }

    public Result loggedoutGET(Context ctx) {

        return Results.html();
    }
    
}