--
--  Copyright (c) 2022 - 2023 Daimler TSS GmbH
--
--  This program and the accompanying materials are made available under the
--  terms of the Apache License, Version 2.0 which is available at
--  https://www.apache.org/licenses/LICENSE-2.0
--
--  SPDX-License-Identifier: Apache-2.0
--
--  Contributors:
--       Daimler TSS GmbH - Initial SQL Query
--       Bayerische Motoren Werke Aktiengesellschaft (BMW AG) - improvements
--

-- THIS SCHEMA HAS BEEN WRITTEN AND TESTED ONLY FOR POSTGRES

-- table: edc_participant
CREATE TABLE IF NOT EXISTS edc_participant (
	participant_id varchar(255) NOT NULL,
	url varchar(255) NOT NULL,
	created_at int8 NOT NULL,
	shared_url varchar(255) NOT NULL,
	CONSTRAINT edc_participant_pkey PRIMARY KEY (participant_id)
);

INSERT INTO edc_participant (participant_id,url,created_at,shared_url) VALUES ('connector-c1','
http://connector-c1:19194/protocol',42893849,'http://connector-c1:19196/shared');
INSERT INTO edc_participant (participant_id,url,created_at,shared_url) VALUES ('connector-c2','
http://connector-c2:29194/protocol',42893849,'http://connector-c2:29196/shared');