require 'test_helper'

class DummyControllerTestClass; end

test_class = if ActionPack.gem_version < Gem::Version.new('5.0.0')
               ActionController::TestCase
             else
               DummyControllerTestClass
             end

class KwargsControllerTest < test_class
  def setup
    Rails::ForwardCompatibleControllerTests.raise_exception
  end

  %w[get post patch put head delete].each do |verb|
    define_method("test_#{verb}_old_params_only") do
      Rails::ForwardCompatibleControllerTests.ignore

      send(verb.to_sym, :test_kwargs, hello: 'world')
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_nil assigns(:hello_header)
      refute assigns(:xhr)
    end

    define_method("test_#{verb}_old_params_only__outputs_deprecation") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_deprecated do
        send(verb.to_sym, :test_kwargs, hello: 'world')
      end
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_nil assigns(:hello_header)
      refute assigns(:xhr)
    end


    define_method("test_#{verb}_old_params_only__raises_exception") do
      assert_raise Exception do
        send(verb.to_sym, :test_kwargs, hello: 'world')
      end
    end

    define_method("test_#{verb}_new_params_only") do
      send(verb.to_sym, :test_kwargs, params: { hello: 'world' })
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_nil assigns(:hello_header)
      refute assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_params_only") do
      Rails::ForwardCompatibleControllerTests.ignore

      xhr verb.to_sym, :test_kwargs, hello: 'world'
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_nil assigns(:hello_header)
      assert assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_params_only__outputs_deprecation") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_deprecated do
        xhr verb.to_sym, :test_kwargs, hello: 'world'
      end
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_nil assigns(:hello_header)
      assert assigns(:xhr)
    end


    define_method("test_xhr_#{verb}_old_params_only__raises_exception") do
      assert_raise Exception do
        xhr verb.to_sym, :test_kwargs, hello: 'world'
      end
    end

    define_method("test_xhr_#{verb}_new_params_only") do
      send(verb.to_sym, :test_kwargs, xhr: true, params: { hello: 'world' })
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_nil assigns(:hello_header)
      assert assigns(:xhr)
    end

    define_method("test_#{verb}_old_headers_only") do
      Rails::ForwardCompatibleControllerTests.ignore

      send(verb.to_sym, :test_kwargs, nil, 'Hello': 'world')
      assert_equal('world', assigns(:hello_header))
      assert_equal({}, assigns(:params))
      refute assigns(:xhr)
    end

    define_method("test_#{verb}_old_headers_only__outputs_deprecation") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_deprecated do
        send(verb.to_sym, :test_kwargs, nil, 'Hello': 'world')
      end
      assert_equal('world', assigns(:hello_header))
      assert_equal({}, assigns(:params))
      refute assigns(:xhr)
    end

    define_method("test_#{verb}_old_headers_only__raises_exception") do
      assert_raise Exception do
        send(verb.to_sym, :test_kwargs, nil, 'Hello': 'world')
      end
    end

    define_method("test_#{verb}_new_headers_only") do
      send(verb.to_sym, :test_kwargs, headers: { 'Hello': 'world' })
      assert_equal('world', assigns(:hello_header))
      assert_equal({}, assigns(:params))
      refute assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_headers_only") do
      Rails::ForwardCompatibleControllerTests.ignore

      xhr(verb.to_sym, :test_kwargs, nil, 'Hello': 'world')
      assert_equal('world', assigns(:hello_header))
      assert_equal({}, assigns(:params))
      assert assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_headers_only__outputs_deprecation") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_deprecated do
        xhr(verb.to_sym, :test_kwargs, nil, 'Hello': 'world')
      end
      assert_equal('world', assigns(:hello_header))
      assert_equal({}, assigns(:params))
      assert assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_headers_only__raises_exception") do
      assert_raise Exception do
        xhr(verb.to_sym, :test_kwargs, nil, 'Hello': 'world')
      end
    end

    define_method("test_xhr_#{verb}_new_headers_only") do
      send(verb.to_sym, :test_kwargs, xhr: true, headers: { 'Hello': 'world' })
      assert_equal('world', assigns(:hello_header))
      assert_equal({}, assigns(:params))
      assert assigns(:xhr)
    end

    define_method("test_#{verb}_old_params_and_headers") do
      Rails::ForwardCompatibleControllerTests.ignore

      send(verb.to_sym, :test_kwargs, { hello: 'world' }, { 'Hello': 'world' })
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      refute assigns(:xhr)
    end

    define_method("test_#{verb}_old_params_and_headers__outputs_deprecation") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_deprecated do
        send(verb.to_sym, :test_kwargs, { hello: 'world' }, { 'Hello': 'world' })
      end
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      refute assigns(:xhr)
    end

    define_method("test_#{verb}_old_params_and_headers__raises_exception") do
      assert_raise Exception do
        send(verb.to_sym, :test_kwargs, { hello: 'world' }, { 'Hello': 'world' })
      end
    end

    define_method("test_#{verb}_new_params_and_headers") do
      send(verb.to_sym, :test_kwargs, params: { hello: 'world' }, headers: { 'Hello': 'world' })
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      refute assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_params_and_headers") do
      Rails::ForwardCompatibleControllerTests.ignore

      xhr verb.to_sym, :test_kwargs, { hello: 'world' }, { 'Hello': 'world' }
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      assert assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_params_and_headers__deprecated") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_deprecated do
        xhr verb.to_sym, :test_kwargs, { hello: 'world' }, { 'Hello': 'world' }
      end
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      assert assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_old_params_and_headers__raises_exception") do
      assert_raise Exception do
        xhr verb.to_sym, :test_kwargs, { hello: 'world' }, { 'Hello': 'world' }
      end
    end

    define_method("test_xhr_#{verb}_new_params_and_headers") do
      send(verb.to_sym, :test_kwargs, xhr: true, params: { hello: 'world' }, headers: { 'Hello': 'world' })
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      assert assigns(:xhr)
    end

    define_method("test_xhr_#{verb}_new_params_and_headers__does_not_output_warning") do
      Rails::ForwardCompatibleControllerTests.deprecate

      assert_not_deprecated do
        send(verb.to_sym, :test_kwargs, xhr: true, params: { hello: 'world' }, headers: { 'Hello': 'world' })
      end
      assert_equal({ 'hello' => 'world' }, assigns(:params))
      assert_equal('world', assigns(:hello_header))
      assert assigns(:xhr)
    end
  end
end
