import { fillIn, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import InputField from '@crowdstrike/ember-toucan-core/components/form/input-field';
import sinon from 'sinon';
import { setupRenderingTest } from 'test-app/tests/helpers';


module('Integration | Component | InputField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        />
    </template>);

    const label = 'label'
    const input = 'input';

    assert.dom(label).exists('Expected to have label block rendered');
    assert.dom(label).hasText('Label', 'Expected to have label text "label"');

    assert.dom(input).exists('Expected to have input tag rendered');
    assert.dom(input).hasAttribute('type', 'text');
  });

  test('it encourages @label via assert', async function (assert) {
    assert.expect(1)

    setupOnerror((e:Error) => {
      assert.strictEqual(e.message, 'Assertion Failed: input field requires a label', 'Expected an error message if @label is not provided')
    })
    await render(<template>
      {{! @glint-expect-error: should have an error here for missing @label }} 
      <InputField
        type="text"
        />
    </template>);

  })
  
  test('it renders an error', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        @error="There is an error"
        />
    </template>);

    const label = 'label'
    const input = 'input';
    const error = 'div.text-critical';
   
    const inputElement = document.querySelector('input.m-1');
 
    const [id] = inputElement?.getAttribute('aria-describedby')?.trim().split(' ') ?? '';
  
    assert.dom(label).exists('Expected to have label component rendered');
    assert.dom(label).hasText('Label', 'Expected to have label text "label"');

    assert.dom(input).exists('Expected to have input tag rendered');
    assert.dom(input).hasAttribute('type', 'text');
   
    assert.dom(error).exists('Expected to have error component rendered');
    assert.dom(error).hasText('There is an error', 'Expected to have error text "error"');

    if (id) {
      assert.dom(error).hasAttribute('id', id);
    }
  });

  test('it renders hint text', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        @hint="Hint text visible here"
        />
    </template>);

    const label = 'label'
    const input = 'input';
    const hint = 'div.type-xs-tight';
    
    const inputElement = document.querySelector('input.m-1');
 
    const [id] = inputElement?.getAttribute('aria-describedby')?.trim().split(' ') ?? '';

    assert.dom(label).exists('Expected to have label component rendered');
    assert.dom(label).hasText('Label', 'Expected to have label text "label"');

    assert.dom(input).exists('Expected to have input tag rendered');
    assert.dom(input).hasAttribute('type', 'text');
   
    assert.dom(hint).exists('Expected to have hint component rendered');
    assert.dom(hint).hasText('Hint text visible here', 'Expected to have hint text "error"');

    if (id) {
     assert.dom(hint).hasAttribute('id', id);
    }
  });

  test('it accepts @value and @onChange', async function (assert) {
    const onChangeCallback = sinon.spy();
  
    await render(<template>
        <InputField
          @label="Label"
          type="text"
          @value="Avocado"
          @onChange={{onChangeCallback}}
          />
      </template>);

    const input: HTMLInputElement | null  = document.querySelector('input.m-1');

    if (!input) {
      throw new Error('an input was not detected');
    }
    
    assert.strictEqual(input.value, 'Avocado', 'input has the set @value');

    await fillIn('input.m-1', 'Banana');

    assert.strictEqual(input.value, 'Banana', 'input has the set @value');
    assert.true(onChangeCallback.called, '@onChange has been called');

    assert.strictEqual(onChangeCallback.getCall(0).firstArg, 'Banana', '@onChange called with @value and event');

    // the input event is quite large, so testing just for the value
    assert.strictEqual(onChangeCallback.getCall(0).lastArg.target.value, 'Banana', '@onChange called with @value and event');
  });

});
