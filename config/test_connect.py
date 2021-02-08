import os, sys
if CONFIG_PATH_ENV_VAR in os.environ:
    # Explicitly import config module that is not necessarily in pythonpath; useful
    # for case where app is being executed via pex.
    try:
        cfg_path = os.environ[CONFIG_PATH_ENV_VAR]
        module = sys.modules[__name__]
        override_conf = imp.load_source("superset_config", cfg_path)
        for key in dir(override_conf):
            if key.isupper():
                setattr(module, key, getattr(override_conf, key))

        print(f"Loaded your LOCAL configuration at [{cfg_path}]")
    except Exception:
        logger.exception(
            "Failed to import config for %s=%s", CONFIG_PATH_ENV_VAR, cfg_path
        )
        raise
elif importlib.util.find_spec("superset_config") and not is_test():
    try:
        import superset_config  # pylint: disable=import-error
        from superset_config import *  # type: ignore # pylint: disable=import-error,wildcard-import,unused-wildcard-import

        print(f"Loaded your LOCAL configuration at [{superset_config.__file__}]")
    except Exception:
        logger.exception("Found but failed to import local superset_config")
        raise
