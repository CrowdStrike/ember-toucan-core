import { fillIn, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import InputField from '@crowdstrike/ember-toucan-core/components/form/input-field';
import { setupRenderingTest } from 'test-app/tests/helpers';


module('Integration | Component | InputField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        data-input
        />
    </template>);

    const label = '[data-label]'
    const input = '[data-input]';

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
        data-input
        />
    </template>);

    const label = '[data-label]'
    const input = '[data-input]';
    const error = '[data-error]';
   
    const inputElement = document.querySelector('[data-input]');
 
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
        data-input
        />
    </template>);

    const label = '[data-label]'
    const input = '[data-input]';
    const hint = '[data-hint]';
    
    const inputElement = document.querySelector('[data-input]');
 
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
    assert.expect(8);
    
    const onChangeCallback = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'Banana', 'Expected input to match');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };
  
    await render(<template>
        <InputField
          @label="Label"
          type="text"
          @value="Avocado"
          @onChange={{onChangeCallback}}
          data-input
          />
      </template>);

    assert.verifySteps([]);

    const input: HTMLInputElement | null  = document.querySelector('input.m-1');

    if (!input) {
      throw new Error('an input was not detected');
    }
    
    assert.strictEqual(input.value, 'Avocado', 'input has the set @value');

    await fillIn('[data-input]', 'Banana');

    assert.strictEqual(input.value, 'Banana', 'input has the set @value');

    assert.verifySteps(['handleChange']);
  });

});
