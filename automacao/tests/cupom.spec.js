const { test, expect } = require('@playwright/test');

test('CT001 - aplicar cupom válido BEMVINDO10', async ({ page }) => {
  await page.goto('/');

  await page.getByText('Camiseta Essencial').click();

  await page.getByRole('article', { name: 'Camiseta Essencial' }).getByRole('button', { name: /adicionar/i }).click();

  await page.getByRole('link', { name: /carrinho/i }).click();

  await page.getByRole('textbox', { name: /cupom/i }).fill('BEMVINDO10');

  await page.getByRole('button', { name: /aplicar/i }).click();

  await expect(page.getByText(/cupom bemvindo10 aplicado/i)).toBeVisible();

  await expect(page.getByText('R$ 5,99')).toBeVisible();
});