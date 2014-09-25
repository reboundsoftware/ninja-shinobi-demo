CREATE TABLE PERMISSIONS 
(
    id INTEGER NOT NULL,
    permission_name VARCHAR(30) NOT NULL, 
    description VARCHAR(255), 
    PRIMARY KEY (id)
);

CREATE TABLE ROLES 
(
    id INTEGER NOT NULL,
    role_name VARCHAR(20) NOT NULL, 
    description VARCHAR(255), 
    PRIMARY KEY (id)
);

CREATE TABLE ROLES_PERMISSIONS 
(
    role_id INTEGER NOT NULL, 
    permission_id INTEGER NOT NULL
);

CREATE TABLE USERS 
(
    id INTEGER NOT NULL,
    user_name VARCHAR(255) NOT NULL, 
    password VARCHAR(255) NOT NULL, 
    PRIMARY KEY (id)
);

CREATE TABLE USERS_ROLES 
(
    user_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL
);

ALTER TABLE ROLES_PERMISSIONS add constraint RP_1 foreign key (role_id) references ROLES (id);
ALTER TABLE ROLES_PERMISSIONS add constraint RP_2 foreign key (permission_id) references PERMISSIONS (id);
ALTER TABLE USERS_ROLES add constraint UR_1 foreign key (user_id) references USERS (id);
ALTER TABLE USERS_ROLES add constraint UR_2 foreign key (role_id) references ROLES (id);

INSERT INTO PERMISSIONS(id, permission_name, description) VALUES(1, '*', 'Wildcard permission');
INSERT INTO PERMISSIONS(id, permission_name, description) VALUES(2, 'lightsaber:*', 'Everything with a lightsaber');
INSERT INTO PERMISSIONS(id, permission_name, description) VALUES(3, 'winnebago:drive:eagle5', 'allowed to drive the winnebago with plate eagle5');

INSERT INTO USERS (id, user_name, password) VALUES(1, 'root', '$shiro1$SHA-256$500000$grF8m/snWFRHE1uvJ7gz3A==$N1CZAcGCtDSG1BcQg/q+7t2VVYBMecFjlQ4bGSw6mnw='); -- pw: secret
INSERT INTO USERS (id, user_name, password) VALUES(2, 'guest', '$shiro1$SHA-256$500000$IvAXNJEolpMvdMcgyLY+qw==$lxAyECA1QIKwB3w78ldRd5G8u8c5DLcVloI/0o2ZGBs='); -- pw: guest
INSERT INTO USERS (id, user_name, password) VALUES(3, 'presidentskroob', '$shiro1$SHA-256$500000$NsedS0ahfxsrVzsHGUg/FA==$CFzhtL46/ycpdgvam45R11czGXEG4wuO/M0oRvNJqr0='); -- pw: 12345
INSERT INTO USERS (id, user_name, password) VALUES(4, 'darkhelmet', '$shiro1$SHA-256$500000$WDco//DaNSl5nxG1MggKiA==$ARdh1aOHDJj4puJILeGSMUBaTpL6ey+SrU4fC74CxkE='); -- pw: ludicrousspeed
INSERT INTO USERS (id, user_name, password) VALUES(5, 'lonestarr', '$shiro1$SHA-256$500000$pA2XXipOtb+ylDzZ9LGaDw==$RADIqt6ZdmhXQlbzF9nYN6BpUarNV91Mwpt0BboCjCQ='); -- pw: vespa

INSERT INTO ROLES (id, role_name, description) VALUES(1, 'admin', 'role has all permissions, indicated by the wildcard "*"');
INSERT INTO ROLES (id, role_name, description) VALUES(2, 'schwartz', 'The "schwartz" role can do anything (*) with any lightsaber');
INSERT INTO ROLES (id, role_name, description) VALUES(3, 'goodguy', 'The "goodguy" role is allowed to "drive" (action) the winnebago (type) with license plate "eagle5" (instance specific id)');

INSERT INTO USERS_ROLES (user_id, role_id) VALUES(1, 1);
INSERT INTO USERS_ROLES (user_id, role_id) VALUES(4, 2);
INSERT INTO USERS_ROLES (user_id, role_id) VALUES(5, 2);
INSERT INTO USERS_ROLES (user_id, role_id) VALUES(5, 3);

INSERT INTO ROLES_PERMISSIONS(role_id, permission_id) VALUES(1, 1);
INSERT INTO ROLES_PERMISSIONS(role_id, permission_id) VALUES(2, 2);
INSERT INTO ROLES_PERMISSIONS(role_id, permission_id) VALUES(3, 3);
