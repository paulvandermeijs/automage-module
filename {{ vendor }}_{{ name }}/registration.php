<?php

use Magento\Framework\Component\ComponentRegistrar;

ComponentRegistrar::register(
    ComponentRegistrar::MODULE,
    "{{ vendor }}_{{ name }}",
    __DIR__
);
