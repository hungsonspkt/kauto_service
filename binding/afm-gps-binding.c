/*
 * Copyright (C) 2017 Konsulko Group
 * Author: Matt Ranostay <matt.ranostay@konsulko.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define _GNU_SOURCE
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <gps.h>
#include <time.h>
#include <pthread.h>
#include <json-c/json.h>
#include <sys/signal.h>
#include <sys/time.h>

#define AFB_BINDING_VERSION 3
#include <afb/afb-binding.h>

static struct gps_data_t data;
static afb_event_t location_event;

static void get_data(afb_req_t request)
{
}

/*
 * Test to see if in demo mode first, then enable if not enable gpsd
 */

static int init(afb_api_t api)
{
	return 0;
}

//static const struct afb_verb_v3 binding_verbs[] = {
static const afb_verb_t binding_verbs[] = {
	{ .verb = "location",    .callback = get_data,     .info = "Get GNSS data" },
	{ }
};

/*
 * binder API description
 */
//const struct afb_binding_v3 afbBindingV3 = {
const afb_binding_t afbBindingV3 = {
	.api = "gps",
	.specification = "GNSS/GPS API",
	.verbs = binding_verbs,
	.preinit = NULL,
	.init = init,
	.onevent = NULL,
	.userdata = NULL,
	.provide_class = NULL,
	.require_class = NULL,
	.require_api = NULL,
	.noconcurrency = 0
};
