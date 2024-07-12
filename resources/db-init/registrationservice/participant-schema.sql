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
CREATE TABLE IF NOT EXISTS edc_participant
(
    participant_id           VARCHAR NOT NULL,
    url                      VARCHAR NOT NULL,
    created_at               BIGINT  NOT NULL,
    PRIMARY KEY (participant_id)
);
