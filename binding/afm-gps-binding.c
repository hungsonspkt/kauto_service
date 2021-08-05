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
#include <stdio.h>
  #include <string.h>
  #include <json-c/json.h>

  #define AFB_BINDING_VERSION 3
  #include <afb/afb-binding.h>

  static void pingSample(afb_req_t request)
  {
    static int pingcount = 0;

    afb_req_success_f(request, json_object_new_int(pingcount), "Ping count = %d", pingcount);

    AFB_API_NOTICE(afbBindingV3root, "Verbosity macro at level notice invoked at ping invocation count = %d", pingcount);

    pingcount++;
  }

  static void count(afb_req_t request)
  {
    static int counter = 0;

    afb_req_success_f(request, json_object_new_int(counter), "Counter = %d", counter);

    AFB_API_NOTICE(afbBindingV3root, "Verbosity macro at level notice invoked at count invocation count = %d", counter);

    counter++;
  }

static const afb_verb_t binding_verbs[] = {
	 /*Without security*/
    {.verb = "ping", .session = AFB_SESSION_NONE, .callback = pingSample, .auth = NULL},
    {.verb = "count", .session = AFB_SESSION_NONE, .callback = count, .auth = NULL},
    {NULL}
};

/*
 * binder API description
 */
const afb_binding_t afbBindingV3 = {
	.api = "count",
    .specification = "HelloCount API",
    .verbs = verbs,
    .preinit = NULL,
    .init = NULL,
    .onevent = NULL,
    .userdata = NULL,
    .provide_class = NULL,
    .require_class = NULL,
    .require_api = NULL,
    .noconcurrency = 0
};
