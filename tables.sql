create database odinbook;

create table if not exists accounts(
id integer primary key GENERATED ALWAYS AS IDENTITY,
picture varchar(280),
fullname varchar(50) not null,
username varchar(50) not null,
email varchar(50) unique not null,
roles varchar(50) not null,
password varchar(280) not null,
is_verified boolean,
about_me text,
created_date timestamp
);

create table if not exists posts(
id integer primary key GENERATED ALWAYS AS IDENTITY,
account_id integer not null,
content text,
shared_from_post_id integer,
is_edited boolean,
is_deleted boolean,
is_followers_visible boolean,
friends_visibility_type boolean,
created_date timestamp,
foreign key(shared_from_post_id) references posts(id) on delete cascade,
foreign key(account_id) references accounts(id) on delete cascade
);


create table if not exists followers(
follower_id integer not null,
followee_id integer not null,
foreign key(follower_id) references accounts(id) on delete cascade,
foreign key(followee_id) references accounts(id) on delete cascade
);


create table if not exists friends(
adding_id integer not null,
added_id integer not null,
foreign key(adding_id) references accounts(id) on delete cascade,
foreign key(added_id) references accounts(id) on delete cascade
);


create table if not exists posts_friends_visibility(
post_id integer not null,
friend_id integer not null,
foreign key (post_id) references posts(id) on delete cascade,
foreign key (friend_id) references accounts(id) on delete cascade
);


create table if not exists likes(
account_id integer not null,
post_id integer not null,
foreign key(account_id) references accounts(id) on delete cascade,
foreign key(post_id) references posts(id) on delete cascade
);


create table if not exists tokens(
id integer primary key GENERATED ALWAYS AS IDENTITY,
type varchar(60) not null,
account_email varchar(60) not null,
code varchar(300) not null,
created_date timestamp
);


create table if not exists comments(
id integer primary key GENERATED ALWAYS AS IDENTITY,
account_id integer not null,
post_id integer not null,
content text not null,
created_date timestamp,
foreign key(account_id) references accounts(id) on delete cascade,
foreign key(post_id) references posts(id) on delete cascade
);

create table if not exists notifications(
id integer primary key GENERATED ALWAYS AS IDENTITY,
type varchar(50) not null,
account_id integer,
adding_id integer,
added_id integer,
receiver_id integer,
post_id integer,
comment_id integer,
is_request boolean,
is_accepted boolean,
is_created boolean,
is_viewed boolean,
created_date timestamp,
foreign key(account_id) references accounts(id) on delete cascade,
foreign key(adding_id) references accounts(id) on delete cascade,
foreign key(added_id) references accounts(id) on delete cascade,
foreign key(receiver_id) references accounts(id) on delete cascade,
foreign key(post_id) references posts(id) on delete cascade,
foreign key(comment_id) references comments(id) on delete cascade

);

create table if not exists messages(
id integer primary key GENERATED ALWAYS AS IDENTITY,
sender_id integer not null,
receiver_id integer not null,
content text,
is_viewed boolean,
is_deleted boolean,
created_date timestamp,
foreign key(sender_id) references accounts(id) on delete cascade,
foreign key(receiver_id) references accounts(id) on delete cascade
);

CREATE FUNCTION clean_post() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM comments WHERE OLD.id = post_id;
    DELETE FROM likes WHERE OLD.id = post_id;
    DELETE FROM notifications WHERE OLD.id = post_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER clean_post_trigger
BEFORE UPDATE ON posts
FOR EACH ROW
WHEN (NEW.is_deleted = true AND OLD.is_deleted = false)
EXECUTE FUNCTION clean_post();       

INSERT INTO accounts(picture, fullname, username, email, roles, password, is_verified, about_me) VALUES('default', 'example', 'example', 'example@gmail.com', 'ROLE_USER', '$2a$10$pGXq2Qy/pCKqChRl68dKKOLvlrekxMpghgjQ3rgl./YGKuyA50xSm', true, 'for demo purpose');

commit;






















