#!/usr/bin/env python2
# -*- coding: utf-8 -*-

from gmusicapi import Musicmanager
import sys

mm = Musicmanager()
mm.login()

mm.upload(sys.argv[1:])
