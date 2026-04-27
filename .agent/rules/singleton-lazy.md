# Backend Singleton Lazy Loading Rule

All backend services, managers, and graph facilitators in the `backend/` directory MUST follow the Singleton pattern with Lazy Loading.

## Pattern Requirements

### 1. Class Structure
- Use a class attribute `_instance` initialized to `None`.
- Define a class method `get_instance(cls, ...)` to handle the lazy initialization.
- **Do not use threading locks** unless explicitly required for high-concurrency external resources (keep it simple by default).

### 2. Implementation Template

```python
class MyManager:
    _instance = None

    def __init__(self, *args, **kwargs):
        if MyManager._instance is not None:
            raise RuntimeError("Use get_instance() instead")
        # Heavy initialization here
    
    @classmethod
    def get_instance(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = cls(*args, **kwargs)
        return cls._instance
```

## Activation
- **Always On** for files matching `backend/**/*.py`.
- Referenced by: `@python-singleton-lazy` skill.

## Reasons
- **Consistency**: Unified way to access core services.
- **Performance**: Lazy loading reduces startup time and memory footprint.
- **Simplicity**: No complex locking logic for standard backend components.
