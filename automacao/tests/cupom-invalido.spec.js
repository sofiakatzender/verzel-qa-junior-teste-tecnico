const { test, expect } = require('@playwright/test');

test('CT004 - aplicar cupom inexistente', async ({ page }) => {
  await page.goto('/');

  await page.getByText('Camiseta Essencial').click();

  await page.getByRole('article', { name: 'Camiseta Essencial' })
    .getByRole('button', { name: /adicionar/i })
    .click();

  await page.getByRole('link', { name: /carrinho/i }).click();

  await page.getByRole('textbox', { name: /cupom/i }).fill('TESTE123');

  await page.getByRole('button', { name: /aplicar/i }).click();

  await expect(page.getByText('Cupom inválido.')).toBeVisible();

  await expect(page.getByText('R$ 0,00')).toBeVisible();
});