import common

def test_common_importable():
    # simply verify that the package can be imported
    assert hasattr(common, "__name__")

def test_dummy_true():
    # a dummy assertion that always passes
    assert True